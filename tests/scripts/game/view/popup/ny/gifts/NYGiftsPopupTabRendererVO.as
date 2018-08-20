package game.view.popup.ny.gifts
{
   public class NYGiftsPopupTabRendererVO
   {
      
      public static const SEND:uint = 0;
      
      public static const RECEIVED:uint = 1;
      
      public static const SENDED:uint = 2;
       
      
      private var _id:uint;
      
      private var _name:String;
      
      public function NYGiftsPopupTabRendererVO(param1:uint, param2:String)
      {
         super();
         this.id = param1;
         this.name = param2;
      }
      
      public function get id() : uint
      {
         return _id;
      }
      
      public function set id(param1:uint) : void
      {
         _id = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
   }
}
