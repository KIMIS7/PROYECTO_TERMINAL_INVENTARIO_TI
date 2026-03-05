-- Migration: Swap Category and Group values in ProductType table
-- The Category field previously stored predefined groups (Equipo, Accesorio, Componente, Otros)
-- and the Group field stored free-text categories. This migration swaps the values
-- so that Group stores the predefined values and Category stores free text.

-- Use a temporary column to perform the swap safely
ALTER TABLE ProductType ADD TempSwap NVARCHAR(150);

-- Copy Category values to temp
UPDATE ProductType SET TempSwap = Category;

-- Move Group values to Category
UPDATE ProductType SET Category = [Group];

-- Move original Category values (from temp) to Group
UPDATE ProductType SET [Group] = TempSwap;

-- Drop the temporary column
ALTER TABLE ProductType DROP COLUMN TempSwap;
