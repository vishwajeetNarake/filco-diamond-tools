# Deploy to Vercel

This guide will help you deploy your Filco Diamond Tools project to Vercel.

## Method 1: Deploy via Vercel Web Interface (Easiest)

1. **Go to Vercel**: Visit [https://vercel.com](https://vercel.com) and sign in (or create an account)

2. **Import your GitHub repository**:
   - Click "Add New..." → "Project"
   - Select "Import Git Repository"
   - Find and select `vishwajeetNarake/filco-diamond-tools`
   - Click "Import"

3. **Configure the project**:
   - **Framework Preset**: Leave as "Other" or "Static Site"
   - **Root Directory**: Leave as `./` (default)
   - **Build Command**: Leave empty (no build needed for static HTML)
   - **Output Directory**: Leave as `./` (default)
   - **Install Command**: Leave empty

4. **Deploy**:
   - Click "Deploy"
   - Wait for deployment to complete
   - Your site will be live at a URL like: `filco-diamond-tools.vercel.app`

5. **Custom Domain (Optional)**:
   - After deployment, go to Project Settings → Domains
   - Add your custom domain if you have one

## Method 2: Deploy via Vercel CLI

### Prerequisites
- Node.js installed (download from [nodejs.org](https://nodejs.org/))
- Vercel CLI installed

### Steps

1. **Install Vercel CLI** (if not already installed):
   ```powershell
   npm install -g vercel
   ```

2. **Login to Vercel**:
   ```powershell
   vercel login
   ```

3. **Navigate to your project directory**:
   ```powershell
   cd c:\Users\narak\Downloads\factry
   ```

4. **Deploy to Vercel**:
   ```powershell
   vercel
   ```
   - Follow the prompts:
     - Set up and deploy? **Yes**
     - Which scope? Select your account
     - Link to existing project? **No** (for first deployment)
     - Project name? **filco-diamond-tools** (or press Enter for default)
     - Directory? **./** (press Enter)
     - Override settings? **No** (press Enter)

5. **For production deployment**:
   ```powershell
   vercel --prod
   ```

## Method 3: Automatic Deployment via GitHub Integration

Once you've connected your GitHub repository to Vercel (via Method 1), Vercel will automatically deploy:
- Every push to the `main` branch → Production deployment
- Every pull request → Preview deployment

## Configuration

The `vercel.json` file is already configured with:
- Proper routing for `index-2.html` as the homepage
- Security headers
- Cache optimization for static assets

## Troubleshooting

### If your site shows a 404 error:
- Make sure `vercel.json` is in the root directory
- Check that `index-2.html` exists

### If assets don't load:
- Verify all asset paths are relative (not absolute)
- Check that the `assets/` folder is included in the repository

### If you need to update the deployment:
- Just push changes to GitHub (if using GitHub integration)
- Or run `vercel --prod` again from the CLI

## Your Live Site

After deployment, your site will be available at:
- **Production**: `https://filco-diamond-tools.vercel.app` (or your custom domain)
- **Preview**: Each deployment gets a unique preview URL

## Need Help?

- Vercel Documentation: [https://vercel.com/docs](https://vercel.com/docs)
- Vercel Support: [https://vercel.com/support](https://vercel.com/support)
