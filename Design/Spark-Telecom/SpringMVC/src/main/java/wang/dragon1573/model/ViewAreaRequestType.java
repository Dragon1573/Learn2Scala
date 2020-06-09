package wang.dragon1573.model;

/**
 * v_area_requestType视图（MySQL映射）
 *
 * @author Dragon1573
 */
public class ViewAreaRequestType {
    /** 区域名称 */
    private String areaName;
    /** 请求类型 */
    private String requestTypeName;
    /** 用户数量 */
    private int num;

    public String getAreaName() {
        return areaName;
    }

    public void setAreaName(final String areaName) {
        this.areaName = areaName;
    }

    public String getRequestTypeName() {
        return requestTypeName;
    }

    public void setRequestTypeName(final String requestTypeName) {
        this.requestTypeName = requestTypeName;
    }

    public int getNum() {
        return num;
    }

    public void setNum(final int num) {
        this.num = num;
    }
}
