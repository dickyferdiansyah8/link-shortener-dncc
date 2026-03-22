<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Str;
use Illuminate\Http\Request;

// 1. Tampilan Halaman Utama
Route::get('/', function () {
    return view('welcome');
});

// 2. Proses Pendekkan Link
Route::post('/shorten', function (Request $request) {
    $url = $request->input('url');
    $code = Str::random(6); // Membuat 6 karakter acak
    
    // Simpan ke Cache selama 24 jam (agar tidak perlu database dulu)
    Cache::put($code, $url, now()->addDay());
    
    return "Link pendek berhasil dibuat! <br> Akses di: <a href='".url($code)."'>".url($code)."</a>";
});

// 3. Logika Redirect
Route::get('/{code}', function ($code) {
    $url = Cache::get($code);
    if ($url) {
        return redirect()->away($url);
    }
    return abort(404, 'Link tidak ditemukan atau sudah kadaluarsa');
});