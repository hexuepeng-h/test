package com.medical.appointment.feign;

import com.medical.appointment.common.Result;
import com.medical.appointment.model.vo.DoctorVO;
import com.medical.appointment.model.vo.PatientVO;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;

/**
 * 用户服务Feign客户端
 */
@FeignClient(value = "medical-user")
public interface UserFeignClient {

    /**
     * 通过ID获取用户详情
     *
     * @param id 用户ID
     * @param token 令牌
     * @return 用户详情
     */
    @GetMapping("/users/users/{id}")
    Result<PatientVO> getUserById(@PathVariable String id, @RequestHeader("Authorization") String token);

    /**
     * 通过ID获取医生详情
     *
     * @param id 医生ID
     * @param token 令牌
     * @return 医生详情
     */
    @GetMapping("/users/doctors/{id}")
    Result<DoctorVO> getDoctorById(@PathVariable String id, @RequestHeader("Authorization") String token);
}
