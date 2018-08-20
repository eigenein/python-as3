package game.data.storage.resource
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.data.storage.gear.GearItemDescription;
   
   public class ScrollItemDescription extends InventoryItemDescription
   {
       
      
      private var _gear:GearItemDescription;
      
      public function ScrollItemDescription(param1:Object = null)
      {
         super(InventoryItemType.SCROLL,param1);
      }
      
      function setGear(param1:GearItemDescription) : void
      {
         this._gear = param1;
      }
      
      public function get gear() : GearItemDescription
      {
         return _gear;
      }
      
      override public function applyLocale() : void
      {
         _name = Translate.translate("LIB_SCROLL_NAME_" + id);
         if(_gear)
         {
            _name = Translate.translateArgs("LIB_SCROLL_NAME",_gear.name);
            _descText = Translate.translateArgs("LIB_SCROLL_DESC",_gear.name);
         }
         else
         {
            _descText = Translate.translateArgs("LIB_SCROLL_DESC",_name);
         }
      }
   }
}
