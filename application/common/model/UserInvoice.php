<?php
namespace app\common\model;

use think\model\concern\SoftDelete;
use think\Validate;

class UserInvoice extends BaseModel
{
    protected $name = 's_user_invoice';

    public static $fields_type_info = [
        [
            'name'  => '个人/明细',
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

    //获取发票数据
    public function getInvoice($type,$array=[])
    {
        $fields_type_info = self::$fields_type_info;
        if(isset($fields_type_info[$type])){
            $info = $fields_type_info[$type]['info'];
            $data = [];
            foreach ($info as $vo) {
                if(!empty($array[$vo['field']])) {
                    $data[$vo['field']] = $array[$vo['field']];
                }
            }
            if(empty($data)){
                return [false,'请输入发票数据',[]];
            }
            $data['type'] = $type;
            return [true,'',$data];
        }else{
            return [false,'发票类型异常',[]];
        }
    }

    //获取发票数据
    public function getInvoiceInfo($type,array $value)
    {
        $fields_type_info = self::$fields_type_info;

        if(isset($fields_type_info[$type])){
            $info = $fields_type_info[$type]['info'];

            $data[] = ['name'=>'发票类型','value'=>$fields_type_info[$type]['name']];
            foreach ($info as $vo) {
                $arr =  ['name'=>$vo['name'],'value'=>''];
                if(!empty($value[$vo['field']])) {
                    $arr['value'] = $value[$vo['field']];
                    $data[] = $arr;
                }
            }
            return $data;
        }else{
            return [];
        }
    }


    //获取发票信息
    public function getAllInvoice($user_id)
    {
        $model_invoice = $this->where('uid',$user_id)->find();
        $data = self::$fields_type_info;
        foreach($data as &$vo){
            foreach ($vo['info'] as &$info){
                if($info['type']=='file'){
                    $info['value'] = isset($model_invoice[$info['field']])?get_image_location($model_invoice[$info['field']],true):'';
                }else{
                    $info['value'] = isset($model_invoice[$info['field']])?$model_invoice[$info['field']]:'';
                }
            }
        }
        return $data;
    }


}