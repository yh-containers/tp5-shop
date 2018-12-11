<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 流年 <liu21st@gmail.com>
// +----------------------------------------------------------------------

// 应用公共文件
//共用语言
function c_lang($name, $key = '')
{


    $result = lang($name);

    if (is_array($result)) {
        if (strpos($key, '.')) {
            list($key, $index) = explode('.',$key);
        } else {
            empty($key) && abort('200', lang('g_error_no_unspecified_lang_key :name', ['name' => $name]));
        }

        if(!array_key_exists($key,$result)) {//不存在索引
//            dump($key);exit;
            abort('200', lang('g_error_no_unspecified_lang_key :name :index', ['name' => $name,'index'=>$key]));

        }elseif(isset($index)){
            !array_key_exists($index,$result[$key]) &&
            abort('200', lang('g_error_no_unspecified_lang_key :name[:key] :index', ['name' => $name,'key'=>$key,'index'=>$index]));

            $result = $result[$key][$index];
        }else{
            $result = $result[$key];
        }
    }
    return $result;
}

//检测语言是否有数据
function c_lang_check($name, $key = '')
{


    $result = lang($name);

    if (is_array($result)) {
        if (strpos($key, '.')) {
            list($key, $index) = explode('.',$key);
        } else {
            if(empty($key)){
                return false;
            }
        }

        if(!array_key_exists($key,$result)) {//不存在索引
            return false;
        }elseif(isset($index)){
            if(!array_key_exists($index,$result[$key])){
              return false;
            }
        }
    }

    return empty($result) ? false : true;
}


//获取图片
function get_image_location($img,$domain=false)
{
    if(is_array($img)){
        foreach($img as &$vo){
            if(preg_match('/^https?/',$vo)){

            }else{
                $vo= ($domain?app()->config('file_domain'):'').DIRECTORY_SEPARATOR.$vo;
            }
        }
    }else{
        if(preg_match('/^https?/',$img)){

        }else{
            $img= ($domain?app()->config('file_domain'):'').DIRECTORY_SEPARATOR.$img;
        }
    }

    return $img;
}


//生成二维码
function generateQrCode()
{
    $qrCode = new \Endroid\QrCode\QrCode('Life is too short to be generating QR codes');

    header('Content-Type: '.$qrCode->getContentType());
    echo $qrCode->writeString();
}

/*
 * 过滤多余数据
 * 请注意键名冲突
 * */
function filter_data($data,$need_fields,$mode=1)
{
    $result_data = [];
    if ($mode==1) {

    } elseif ($mode==2){
        foreach ($data as $i_key=>$datum){
            foreach ($need_fields as $key=>$vo) {
                $handle_data = $datum[$key]?$datum[$key]:[];
                if(is_object($handle_data)){
                    $handle_data = $handle_data->toArray();
                }
                if(key($handle_data)===0){//说明$vo是一个二维数据
                    foreach ($handle_data as $item){

                        $result_data[$i_key][$key][] = handle_filter_arr($vo,$item);
                    }
//                    dump($result_data);exit;
                }else{
                    $result_data[$i_key][$key] = handle_filter_arr($vo, $handle_data);
                }
            }
        }

    }
    return $result_data;
}

//处理数据
function handle_filter_arr($filed_info, $handle_data)
{
    $data =$auto_data=[];
    foreach ($filed_info as $fk=>$item) {
        $is_change_img = false;
        if(substr($fk,0,1)==='*'){
            $change_key =$search_key = substr($fk,1);
            $is_change_img= true;
        }else{
            $change_key =$search_key = $fk;
        }
        if(strpos($fk,'|')){
            $arr = explode('|',$fk);
            $search_key = $arr[0];
            $change_key = $arr[1];
        }
        if(is_array($item)){
            $auto_data = handle_filter_arr($item,$handle_data[$search_key]);
        }else{
            if($is_change_img){
                $data[$change_key] = isset($handle_data[$search_key])?get_image_location($handle_data[$search_key],true):$item;
            }else{
                $data[$change_key] = isset($handle_data[$search_key])?$handle_data[$search_key]:$item;
            }

        }
        $data = array_merge($data,$auto_data);
    }
    return $data;
}



