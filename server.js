#!/usr/bin/env node
// Dev server: injects Supabase credentials and serves the frontend
const http = require('http');
const fs = require('fs');
const path = require('path');

require('dotenv').config();

const PORT = process.env.PORT || 8080;
const FRONT = path.join(__dirname, 'front');
const SUPABASE_URL = process.env.SUPABASE_URL || '';
const SUPABASE_ANON_KEY = process.env.SUPABASE_ANON_KEY || '';

const MIME = {
  '.html': 'text/html',
  '.js': 'application/javascript',
  '.css': 'text/css',
  '.json': 'application/json',
  '.png': 'image/png',
  '.ico': 'image/x-icon',
};

const inject = (html) => html
  .replace('<!-- SUPABASE_URL -->', `<script>window.SUPABASE_URL='${SUPABASE_URL}';window.SUPABASE_ANON_KEY='${SUPABASE_ANON_KEY}';</script>`);

http.createServer((req, res) => {
  let url = req.url.split('?')[0];
  if (url === '/') url = '/index.html';

  const file = path.join(FRONT, url);
  const ext = path.extname(file);

  fs.readFile(file, (err, data) => {
    if (err) {
      res.writeHead(404);
      res.end('Not found');
      return;
    }
    const contentType = MIME[ext] || 'text/plain';
    res.writeHead(200, { 'Content-Type': contentType });
    if (ext === '.html') {
      res.end(inject(data.toString()));
    } else {
      res.end(data);
    }
  });
}).listen(PORT, () => {
  console.log(`Family Grocery running at http://localhost:${PORT}`);
  if (!SUPABASE_URL) console.warn('WARNING: SUPABASE_URL not set in .env — Supabase will not work');
});