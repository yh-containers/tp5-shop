<?php
namespace app\common\model;

use think\model\concern\SoftDelete;
use think\Validate;

class UserInvoice extends BaseModel
{
    protected $name = 's_user_invoice';

    public static $fields_type_info = [
        [
            'name'  => '普通发票',
            'info' => [
                ['field'=>'inv_payee','name'=>'发票抬头','type'=>'text'],
                ['field'=>'tax_code','name'=>'纳税人识别号','type'=>'text'],
            ]
        ],
        [
            'name'  => '增值税发票',
            'info' => [
                ['field'=>'zz_company_name','name'=>'单位名称','type'=>'text'],
                ['field'=>'zz_tax_code','name'=>'纳税人识别号','type'=>'text'],
                ['field'=>'zz_address','name'=>'注册地址','type'=>'text'],
                ['field'=>'zz_phone','name'=>'注册电话','type'=>'text'],
                ['field'=>'zz_bank','name'=>'开户银行','type'=>'text'],
                ['field'=>'zz_bank_card','name'=>'银行账户','type'=>'text'],
                ['field'=>'zz_credential','name'=>'一般纳税人资格认定证书','type'=>'file'],
            ]
        ]
    ];

}