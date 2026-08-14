# Sleep & Mind Lab

App web (PWA) que cruza horas de sueño contra tres medidas de rendimiento cognitivo (tiempo de reacción, memoria a corto plazo y atención sostenida), usando los datos del propio usuario en vez de promedios poblacionales. Proyecto CAS del IB.

Es HTML/CSS/JS vanilla, sin build step: todo corre en el navegador y los datos quedan guardados en el `localStorage` de quien la usa. Opcionalmente, si se crea una cuenta (email + contraseña), los registros también se sincronizan a Supabase para poder verlos desde otro dispositivo — sin cuenta, sigue siendo 100% local. Nadie más ve los datos de otra persona (ver `supabase-schema.sql`, con RLS por usuario).

**Backend (Supabase)**: proyecto `jukistinzrszdzyosqyk`. La URL y la clave `anon` están directamente en `index.html` (son públicas por diseño, la seguridad real la da RLS en la base, no ocultar la clave). Para replicar la base en otro proyecto, correr `supabase-schema.sql` en el SQL Editor.

## Correr localmente

```bash
python3 -m http.server 8000
```

Abrí `http://localhost:8000`. El service worker (cache offline) necesita `localhost` o HTTPS para funcionar — con `file://` la app anda igual, pero sin cache.

## Actualizar la app en producción

1. Editá los archivos.
2. **Si cambiaste algo del contenido de la app** (no solo el README), subí la versión del cache en `sw.js`:

   ```js
   const CACHE = 'sml-v1';   // → 'sml-v2', 'sml-v3', etc.
   ```

   **Esto es importante.** El service worker sirve todo desde cache primero — si no cambiás este número, quien ya abrió la app antes sigue viendo la versión vieja aunque hayas publicado la nueva. Es el error más común al trabajar con service workers.

3. `git add . && git commit -m "..." && git push`
4. Cloudflare detecta el push al repo de GitHub y publica solo, en 1-2 minutos.

## URL pública

https://sleep-mind-lab.maurizio-binda-09.workers.dev

(Se publica como Worker con integración Git de Cloudflare, conectado al repo [Maurib2009/sleep-mind-lab](https://github.com/Maurib2009/sleep-mind-lab) — no es Cloudflare Pages clásico, pero el resultado es el mismo: push a GitHub → redeploy automático.)
