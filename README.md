# Sleep & Mind Lab

App web (PWA) que cruza horas de sueño contra tres medidas de rendimiento cognitivo (tiempo de reacción, memoria a corto plazo y atención sostenida), usando los datos del propio usuario en vez de promedios poblacionales. Proyecto CAS del IB.

Es HTML/CSS/JS vanilla, sin dependencias, sin build step y sin backend: todo corre en el navegador y los datos quedan guardados solo en el `localStorage` de quien la usa. Nadie más los ve.

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
4. Cloudflare Pages detecta el push y publica solo, en 1-2 minutos.

## URL pública

_(se completa al final del deploy)_
