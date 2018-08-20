package game.mediator.gui.popup.clan.editicon
{
   public class ClanEditIconColorValueObject extends ClanEditIconValueObject
   {
       
      
      private var _color:uint;
      
      public function ClanEditIconColorValueObject(param1:int, param2:uint)
      {
         super(param1);
         _color = param2;
      }
      
      public function get color() : uint
      {
         return _color;
      }
   }
}
