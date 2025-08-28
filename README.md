# setup-helm-plugins (Composite Action)

Action para **instalar e fixar** os plugins do Helm usados nos nossos deploys:

- `helm-diff` (padrão: `v3.9.7`)
- `helm-secrets` (padrão: `v4.6.0`)
- `helm-s3` (padrão: `v0.17.0`)

> Esta action evita “drift” de versões entre pipelines e padroniza o ambiente de deploy.

---

## Uso rápido (TL;DR)

No **repositório consumidor**, adicione **após instalar o Helm** e **antes do helmfile**:

```yaml
- name: Install Helm plugins
  uses: crmbonus-oficial/template-devops/.github/actions/setup-helm-plugins@v1
```

Só isso. 👌

---

## Pré-requisitos

- **Helm** instalado no runner (ex.: v3.12.1).
- **SOPS** e **yq** no `PATH` (requeridos pelo `helm-secrets v4`).
- Permissão para usar esta action:
  - Neste repositório: *Settings → Actions → Access* → **Accessible from repositories in the ‘crmbonus-oficial’ organization** → **Save**.

---

## ⚙️ Inputs (opcionais)

Não é obrigatório passar nada — os *defaults* já atendem.  
Use `with:` apenas para sobrescrever algo:

| Input             | Default   | Descrição                                                 |
|-------------------|-----------|-----------------------------------------------------------|
| `helm_binary`     | `helm`    | Caminho do binário do Helm                                |
| `diff_version`    | `v3.9.7`  | Versão do `databus23/helm-diff`                           |
| `secrets_version` | `v4.6.0`  | Versão do `jkroepke/helm-secrets`                         |
| `s3_version`      | `v0.17.0` | Versão do `hypnoglow/helm-s3`                             |
| `uninstall_first` | `"true"`  | Remove plugins antigos antes de instalar (evita conflito) |

Exemplo com override do caminho do Helm:

```yaml
- uses: crmbonus-oficial/template-devops/.github/actions/setup-helm-plugins@v1
  with:
    helm_binary: /opt/hostedtoolcache/helm/3.12.1/x64/helm
```

---

## Exemplo completo de job

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      # Helm / Helmfile (exemplo)
      - name: Install Helm
        run: |
          curl -L https://get.helm.sh/helm-v3.12.1-linux-amd64.tar.gz -o helm.tgz
          tar xzf helm.tgz && sudo mv linux-amd64/helm /usr/local/bin/helm
          helm version

      - name: Install Helmfile
        run: |
          curl -sSL -o hf.tgz https://github.com/helmfile/helmfile/releases/download/v0.155.0/helmfile_0.155.0_linux_amd64.tar.gz
          mkdir -p hf && tar -xzf hf.tgz -C hf && sudo mv hf/helmfile /usr/local/bin/helmfile
          helmfile --version

      # SOPS + yq (requeridos pelo helm-secrets v4)
      - name: Sops Binary Installer
        uses: mdgreenwald/mozilla-sops-action@v1.4.1

      - name: Ensure yq in PATH
        run: |
          if ! command -v yq >/dev/null; then
            curl -sSL -o yq https://github.com/mikefarah/yq/releases/download/v4.47.1/yq_linux_amd64
            chmod +x yq && sudo mv yq /usr/local/bin/yq
          fi
          yq --version
          sops --version

      # Plugins via template (este repositório)
      - name: Install Helm plugins
        uses: crmbonus-oficial/template-devops/.github/actions/setup-helm-plugins@v1

      # Deploy (exemplo)
      - name: Helmfile apply
        run: helmfile -f path/to/helmfile.yaml apply --suppress-diff-secrets
```

> Usa **AGE**? Carregue a chave antes do apply:
> ```yaml
> - name: Load SOPS AGE key
>   if: ${{ secrets.SOPS_AGE_KEY != '' }}
>   run: |
>     mkdir -p $HOME/.config/sops/age
>     printf '%s\n' "${{ secrets.SOPS_AGE_KEY }}" > $HOME/.config/sops/age/keys.txt
>     chmod 600 $HOME/.config/sops/age/keys.txt
> ```

---

## Atualizando versões para **todos** os repositórios

1. Edite os *defaults* em `.github/actions/setup-helm-plugins/action.yml`.
2. Atualize o **tag** desta action para apontar para o novo commit:
   ```bash
   git tag -fa v1 -m "update v1"
   git push -f origin v1
   ```
Todos os consumidores que usam `@v1` passarão a usar as novas versões automaticamente.

---

## Troubleshooting

- **“Cannot access repositories ‘crmbonus-oficial/template-devops’”**  
  → Neste repo: *Settings → Actions → Access* → **Accessible from repositories in the org** → **Save**.

- **`yq: command not found`**  
  → Adicione o passo “Ensure yq in PATH” (acima).

- **`no plugin command is applicable`**  
  → Conflito/versão incorreta do `helm-secrets`. Garanta que a instalação é feita **apenas** por esta action e que `uninstall_first` está `"true"` (default).