
## 🚀 Deployment

Deployment is fully automated via GitHub Actions:

1. **Infrastructure**: Push to `main` triggers Terraform deployment
2. **Function Code**: Automatically deploys after infrastructure updates

## 🔧 Local Development

```bash
# Using conda
conda activate resume_env
pip install -r backend/requirements.txt