# Filco Diamond Tools

Factory and Industry Service HTML5 Template

## Deployment Instructions

To deploy this project to GitHub, follow these steps:

### Prerequisites
1. Make sure Git is installed on your system. If not, download it from: https://git-scm.com/download/win
2. Make sure you have a GitHub account and are logged in

### Steps to Deploy

1. **Open PowerShell or Command Prompt** in this project directory (`c:\Users\narak\Downloads\factry`)

2. **Initialize Git repository** (if not already initialized):
   ```bash
   git init
   ```

3. **Add all files to Git**:
   ```bash
   git add .
   ```

4. **Create initial commit**:
   ```bash
   git commit -m "Initial commit: Filco Diamond Tools project"
   ```

5. **Add the remote repository**:
   ```bash
   git remote add origin https://github.com/vishwajeetNarake/Filco-Diamond-Tools.git
   ```

6. **Rename the default branch to main** (if needed):
   ```bash
   git branch -M main
   ```

7. **Push to GitHub**:
   ```bash
   git push -u origin main
   ```

### If you encounter authentication issues:

You may need to use a Personal Access Token instead of your password:
1. Go to GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Generate a new token with `repo` permissions
3. Use the token as your password when prompted

### Alternative: Using GitHub Desktop

If you prefer a GUI:
1. Download GitHub Desktop from: https://desktop.github.com/
2. Open GitHub Desktop
3. File → Add Local Repository → Select this folder
4. Publish repository → Choose the repository name: `Filco-Diamond-Tools`

## Project Structure

- `index-2.html` - Main homepage
- `about.html` - About page
- `services.html` - Services page
- `product.html` - Products page
- `assets/` - CSS, JavaScript, images, and other assets
- Other HTML pages for various sections

## License

This is a template project. Please check the original template license for usage terms.
