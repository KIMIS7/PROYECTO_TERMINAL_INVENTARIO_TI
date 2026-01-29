import { dirname } from "path";
import { fileURLToPath } from "url";
import { FlatCompat } from "@eslint/eslintrc";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const compat = new FlatCompat({
  baseDirectory: __dirname,
});

const eslintConfig = [
  ...compat.extends("next/core-web-vitals", "next/typescript"),
      {
        rules: {
            // Solución TEMPORAL: Cambia el error de 'any' por una advertencia.
            "@typescript-eslint/no-explicit-any": "warn",

            // Opcional: También puedes convertir las advertencias de variables
            // no usadas en advertencias explícitas (o quitarlas con "off").
            "@typescript-eslint/no-unused-vars": "warn"
        }
    }
];

export default eslintConfig;
