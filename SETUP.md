# Veenasmagic Kitchen Digital Catalogue

This is a mobile-friendly QR catalogue with an admin login. Once connected to Supabase and deployed, public visitors see the latest active products, while you can sign in to edit prices, weights, descriptions, photos, add products and remove products. The QR code should point to the deployed catalogue URL and does not need to change when products are updated.

## Important security step before publishing

The included SQL is a starter setup. Its admin write policy currently allows any authenticated Supabase user to manage products. Before public launch, replace that policy with a policy restricted to your own admin user UUID (instructions below). Do not publish the app until you have restricted admin writes.

## 1. Create the database
1. Create a project at https://supabase.com.
2. Open SQL Editor in the Supabase dashboard.
3. Run the contents of `supabase-setup.sql`.
4. In Authentication > Users, create your admin user with your email and a strong password.
5. Copy that user's UUID from Authentication > Users.
6. In SQL Editor, replace the broad admin policy with this restricted policy, substituting your UUID:

```sql
drop policy if exists "Authenticated admins can manage products" on public.products;
create policy "Only owner can manage products" on public.products
for all to authenticated
using (auth.uid() = 'YOUR-ADMIN-USER-UUID'::uuid)
with check (auth.uid() = 'YOUR-ADMIN-USER-UUID'::uuid);
```

## 2. Connect the page
1. In Supabase Project Settings > API, copy the Project URL and anon/publishable key. Never use the `service_role` secret key in this page.
2. Open `index.html` in a text editor.
3. Replace `YOUR_SUPABASE_PROJECT_URL` and `YOUR_SUPABASE_ANON_OR_PUBLISHABLE_KEY` with those two values.

## 3. Publish
Upload `index.html` to a static host such as Netlify, Vercel or Cloudflare Pages. For the simplest setup, use a static-site deployment with `index.html` as the entry page. Test the public catalogue and admin login on the deployed URL.

## 4. Make the permanent QR code
After deployment, create a QR code that points to the final public URL (for example `https://your-brand.vercel.app`). Print that QR code on your product labels. Do not use a temporary preview URL. You can update product data in the admin panel without changing this QR code, as long as the deployed URL stays the same.

## Admin usage
- Tap **Admin Login** on the catalogue.
- Sign in with the admin email and password created in Supabase.
- Add or edit product details and save.
- The project includes starter product photographs in the `images` folder. You can keep these or replace them by uploading your own product photos to a public image host and pasting each public HTTPS image URL in the admin panel.
- Removing a product hides it from customers; it is not permanently deleted.

## Design notes
- Product cards do not have individual enquiry buttons; the WhatsApp contact link appears once in the footer.
- The layout is responsive and shows two product cards per row on phones.
- Eight starter pickle photographs are bundled in `images/`. They are illustrative generated food images, not photographs of your actual packaged products. Replace them with your own product photos when available.

## Current seeded products
Mango Achaar, Lemon Dates Achaar, Beetroot Dates Achaar, Ginger Achaar, Shadavari Achaar, Gooseberry Achaar, Pineapple Achaar and Garlic Achaar. Prices are blank until you enter the correct values. Only Mango's 250 g pack size is prefilled based on the supplied label.

## Brand contact details in the page
The page currently uses the contact details shown on the supplied label: +91 98765 43210, veenasmagickitchen@gmail.com, and FSSAI No. 21326190000639. Confirm these before printing.
