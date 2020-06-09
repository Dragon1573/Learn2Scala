package wang.dragon1573.controller;

import java.util.List;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import wang.dragon1573.model.ViewAreaChannel;
import wang.dragon1573.model.ViewAreaRequestType;
import wang.dragon1573.service.UserService;

/**
 * 用户界面控制器
 *
 * @author Dragon1573
 */
@Controller
@RequestMapping("/")
public class UserController {
    /** 日志记录对象 */
    private static final Logger LOGGER = Logger.getLogger(UserController.class);

    /**
     * 用户服务接口
     */
    @Autowired
    private UserService userService;

    public UserController() { }

    public static void main(String[] args) {
        System.out.println("Hello World!");
        UserController userController = new UserController();
        userController.charts();
    }

    /**
     * 图表查询服务
     *
     * @return 模型视图
     */
    @RequestMapping("charts")
    public ModelAndView charts() {
        // 获取用户渠道趋势分析维度
        JSONObject dimAreaChannel = new JSONObject();
        List<String> areaChannelDim = userService.getViewAreaChannelDim();
        for (final String dim : areaChannelDim) {
            JSONArray jsonArray = new JSONArray();
            List<ViewAreaChannel> viewAreaChannelList =
                userService.getViewAreaChannel(dim);
            for (final ViewAreaChannel elem : viewAreaChannelList) {
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("areaName", elem.getAreaName());
                jsonObject.put("num", elem.getNum());
                jsonArray.add(jsonObject);
            }
            dimAreaChannel.put(dim, jsonArray);
        }

        // 用户请求方式对比维度
        JSONObject dimAreaRequestType = new JSONObject();
        List<String> areaRequestTypeDim = userService.getViewAreaRequestTypeDim();
        for (final String dim : areaRequestTypeDim) {
            JSONArray jsonArray = new JSONArray();
            List<ViewAreaRequestType> viewAreaRequestTypeList =
                userService.getViewAreaRequestType(dim);
            for (final ViewAreaRequestType elem : viewAreaRequestTypeList) {
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("areaName", elem.getAreaName());
                jsonObject.put("num", elem.getNum());
                jsonArray.add(jsonObject);
            }
            dimAreaRequestType.put(dim, jsonArray);
        }

        // 用户渠道趋势分析
        ModelAndView modelAndView = new ModelAndView("charts");
        modelAndView.addObject("areaChannelData", dimAreaChannel.toJSONString());
        modelAndView.addObject("areaChannelList", areaChannelDim);
        modelAndView.addObject(
            "areaChannelListAll", userService.getViewAreaChannelAll()
        );
        modelAndView.addObject(
            "areaRequestTypeListAll",
            userService.getViewAreaRequestTypeAll()
        );

        // 用户请求方式对比分析
        modelAndView.addObject("areaRequestTypeData", dimAreaRequestType.toJSONString());
        modelAndView.addObject("areaRequestTypeList", areaRequestTypeDim);

        // 用户渠道饼图分析
        modelAndView.addObject("channelNoList", userService.getViewChannelNo());

        return modelAndView;
    }

    /**
     * 用户详情界面
     *
     * @param areaName
     *     区域名称
     * @param channelName
     *     渠道名称
     * @return 模型视图
     */
    @RequestMapping("detail")
    public ModelAndView detail(
        @RequestParam(value = "areaName") String areaName,
        @RequestParam(value = "channelName") String channelName
    ) {
        ModelAndView modelAndView = new ModelAndView("detail");
        modelAndView.addObject(
            "userDetailList",
            userService.getDetail(areaName, channelName)
        );
        return modelAndView;
    }

    /**
     * 首页
     *
     * @return HTML响应
     */
    @RequestMapping("index")
    public String index() {
        return "index";
    }

    /**
     * 登陆界面（Spring自动映射）
     *
     * @return HTML相应内容
     */
    @RequestMapping(value = "login", produces = "text/html; charset=UTF-8")
    @ResponseBody
    public String login() {
        return "";
    }
}
