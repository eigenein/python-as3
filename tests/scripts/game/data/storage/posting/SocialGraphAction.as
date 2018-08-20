package game.data.storage.posting
{
   public class SocialGraphAction
   {
       
      
      private var _ident:String;
      
      private var _desc:String;
      
      public function SocialGraphAction(param1:Object)
      {
         super();
         _ident = param1.ident;
         _desc = param1.desc;
      }
      
      public function get ident() : String
      {
         return _ident;
      }
      
      public function get desc() : String
      {
         return _desc;
      }
   }
}
