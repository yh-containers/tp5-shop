<?php

namespace app\common\validate;

use think\Validate;

class UserAddr extends Validate
{
    protected $rule = [
        'rec_name'  => 'require|min:0',
        'rec_phone' => 'require|mobile',
        'province'  => 'require',
        'city'      => 'require',
        'area'      => 'require',
        'addr'      => 'require|min:1',
    ];

    protected $message = [
        'rec_name.require'       => '请输入收货人姓名',
        'rec_name.gt'            => '请输入收货人姓名',
        'rec_phone.require'      => '请输入收货人手机号',
        'rec_phone.mobile'       => '请输入正确的手机号',
        'province.require'       => '请选择省',
        'city.require'           => '请选择市',
        'area.require'           => '请选择区',
        'addr.require'           => '请输入详细地址',
        'addr.gt'                => '请输入详细地址长度必须超过 :rule',



    ];
}
