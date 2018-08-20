package game.data.storage.posting
{
   import engine.context.platform.social.posting.ActionType;
   
   public class SocialGraphObject
   {
       
      
      private var _name:String;
      
      private var _desc:String;
      
      private var _image:String;
      
      private var _ident:String;
      
      public function SocialGraphObject(param1:Object)
      {
         super();
         _ident = param1.ident;
         _image = param1.image;
         _name = param1.name;
         _desc = param1.desc;
      }
      
      public function getImage(param1:int, param2:ActionType, param3:String) : String
      {
         return _image.replace("%id%",param1).replace("%locale%",param3).replace("%action%",param2.type);
      }
      
      public function getName(param1:int) : String
      {
         return _name.replace("%id%",param1);
      }
      
      public function getDesc(param1:int) : String
      {
         return _desc.replace("%id%",param1);
      }
      
      public function get ident() : String
      {
         return _ident;
      }
   }
}
