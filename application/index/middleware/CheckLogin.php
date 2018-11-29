<?php
namespace app\index\middleware;

class CheckLogin
{
    public function handle($request, \Closure $next, $name)
    {
        $user_id = $request->param('user_id',0,'intval');
        if($user_id) {
            session('user_info',[
                'user_id' =>$user_id,
            ]);
        }

        return $next($request);
    }
}