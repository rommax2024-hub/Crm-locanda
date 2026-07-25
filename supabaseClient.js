require("dotenv").config();
const { createClient } = require("@supabase/supabase-js");

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SECRET_KEY;

if (!supabaseUrl || !supabaseKey) {
  throw new Error(
    "Mancano SUPABASE_URL o SUPABASE_SECRET_KEY nel file .env"
  );
}

const supabase = createClient(supabaseUrl, supabaseKey);

module.exports = supabase;
