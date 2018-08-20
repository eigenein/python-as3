package game.mediator.gui.popup.clan.editicon
{
   public class ClanEditIconValueObject
   {
       
      
      private var _id:int;
      
      public function ClanEditIconValueObject(param1:int)
      {
         super();
         _id = param1;
      }
      
      public function get id() : int
      {
         return _id;
      }
   }
}
