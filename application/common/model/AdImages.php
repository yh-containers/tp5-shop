<?php
namespace app\common\model;

use think\model\concern\SoftDelete;

class AdImages extends BaseModel
{
    use SoftDelete;
    protected $name = 'ad_images';

    protected $json = ['param'];

}