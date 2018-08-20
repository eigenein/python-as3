package engine.context.platform.social
{
   public class VKSocialFacadeHelper
   {
      
      public static var vk_sid:String;
      
      public static var vk_lead_id:String;
      
      public static var vk_uid:String;
      
      public static var vk_hash:String;
      
      public static var _agdvf_id:String;
      
      public static var admitad_uid:String;
      
      public static var admitad_publisher_id:String;
       
      
      public function VKSocialFacadeHelper(param1:Object)
      {
         super();
         vk_hash = param1.vk_hash;
         vk_lead_id = param1.vk_lead_id;
         vk_sid = param1.vk_sid;
         vk_uid = param1.vk_uid;
      }
   }
}
