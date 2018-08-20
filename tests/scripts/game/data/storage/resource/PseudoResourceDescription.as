package game.data.storage.resource
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.enum.lib.InventoryItemType;
   
   public class PseudoResourceDescription extends InventoryItemDescription
   {
       
      
      private var _constName:String;
      
      public function PseudoResourceDescription(param1:Object = null)
      {
         super(InventoryItemType.PSEUDO,param1);
         _constName = param1.constName;
      }
      
      public function get constName() : String
      {
         return _constName;
      }
      
      override public function applyLocale() : void
      {
         _name = Translate.translate("LIB_PSEUDO_" + _constName);
         _descText = Translate.translate("LIB_PSEUDO_DESC_" + id);
      }
   }
}
