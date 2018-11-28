<?php
namespace app\common\validate;

use think\Validate;

class OrderGoodsBack extends Validate
{
    protected $rule = [
        'content'   =>  'require|length:10,200',
        'img'       =>  'require'
    ];

    protected $message  =   [
        'content.require' => '理由必须输入',
        'content.length'     => '理由字符长度必须在 :1-:2之间',
        'img.require'     => '请上传图片',
    ];
}
