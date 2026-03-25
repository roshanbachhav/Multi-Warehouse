<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;
 
    protected $fillable = [
        'name',
        'email',
        'password',
        'role',
    ];
 
    protected $hidden = [
        'password',
        'remember_token',
    ];

   
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }
 
    public function scopeAdmins($query)
    {
        return $query->where('role', 'admin');
    }

 
    public function scopeManagers($query)
    {
        return $query->where('role', 'manager');
    }
 
    public function isAdmin(): bool
    {
        return $this->role === 'admin';
    }

 
    public function isManager(): bool
    {
        return $this->role === 'manager';
    }
}
