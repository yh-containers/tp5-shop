<?php

namespace app\common\validate;

use think\Validate;

class AdImages extends Validate
{
    protected $rule = [
        'type' => 'require|gt:0',
        'img' => 'require',
        'name' => 'require|max:150',

    ];

    protected $message = [
        'img.require'       => '图片必须上传',
        'type.require'      => '广告图类型异常',
        'type.gt'           => '广告图类型异常 :rule',
        'name.require'      => '名称必须填写',
        'name.max'          => '名称字符长度不能超过 :rule 个字符'

    ];
}
