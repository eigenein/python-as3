package game.mediator.gui.popup.clan
{
   public class ClanEditRolePopupValueObject
   {
       
      
      private var _name:String;
      
      private var _values:Vector.<Boolean>;
      
      public function ClanEditRolePopupValueObject(param1:String, param2:Vector.<Boolean>)
      {
         super();
         this._values = param2;
         this._name = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get values() : Vector.<Boolean>
      {
         return _values;
      }
   }
}
