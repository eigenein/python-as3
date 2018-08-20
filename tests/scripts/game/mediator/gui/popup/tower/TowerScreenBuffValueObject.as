package game.mediator.gui.popup.tower
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.DataStorage;
   import game.data.storage.tower.TowerBuffDescription;
   import game.model.user.tower.PlayerTowerBuffEffect;
   
   public class TowerScreenBuffValueObject
   {
       
      
      private var effect:PlayerTowerBuffEffect;
      
      private var _icon:TowerBuffDescription;
      
      private var _desc:String;
      
      private var _value:String;
      
      public function TowerScreenBuffValueObject(param1:PlayerTowerBuffEffect)
      {
         super();
         this.effect = param1;
         var _loc2_:Vector.<TowerBuffDescription> = DataStorage.tower.getBuffListByEffect(param1.type);
         _icon = _loc2_[0];
         _desc = Translate.translateArgs("LIB_TOWERBUFF_DESC_" + _icon.id,int(param1.value));
         _value = "+" + param1.value + "%";
      }
      
      public function get icon() : TowerBuffDescription
      {
         return _icon;
      }
      
      public function get desc() : String
      {
         return _desc;
      }
      
      public function get value() : String
      {
         return _value;
      }
   }
}
