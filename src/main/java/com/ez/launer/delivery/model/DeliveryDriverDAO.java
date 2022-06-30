package com.ez.launer.delivery.model;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface DeliveryDriverDAO {
    DeliveryDriverVO selectByNo(int no);
    int insertDeliveryAmount(Map<String, Object> map);

    List<Map<String, Object>> amountByDeliveryNo(Map<String, Object> map);

    Map<String, Object> amountAllRecode(Map<String, Object> map);

    List<Map<String, Object>> selectListAll(Map<String, Object> map);
}
