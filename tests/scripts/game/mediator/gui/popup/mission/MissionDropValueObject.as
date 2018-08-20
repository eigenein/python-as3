package game.mediator.gui.popup.mission
{
   import game.data.storage.gear.GearItemDescription;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.resource.ScrollItemDescription;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.reward.GuiElementExternalStyle;
   
   public class MissionDropValueObject
   {
      
      public static const EXCLUDE_PRIORITY_DO_NOT_EXCLUDE:int = 100000000;
      
      public static const PRIORITY_SHOW_LAST:int = 0;
      
      protected static const PRIORITY_HERO:int = 1000000;
      
      protected static const PRIORITY_GEAR:int = 10000;
       
      
      private var _item:InventoryItem;
      
      private var _dropType:String;
      
      private var _sortPriority:Number;
      
      private var _excludePriority:Number;
      
      private var _externalStyleFactory:Function;
      
      public function MissionDropValueObject(param1:InventoryItem, param2:String, param3:Number = NaN, param4:Number = NaN)
      {
         super();
         _item = param1;
         _dropType = param2;
         if(param3 == param3)
         {
            _sortPriority = param3;
         }
         else
         {
            _sortPriority = 0;
            if(param1.item is HeroDescription)
            {
               _sortPriority = _sortPriority + 1000000;
            }
            if(param1.item is GearItemDescription)
            {
               _sortPriority = _sortPriority + 1;
               _sortPriority = _sortPriority + (param1.item as GearItemDescription).color.id * 10000;
               _sortPriority = _sortPriority + (param1.item as GearItemDescription).heroLevel;
            }
            if(param1.item is ScrollItemDescription)
            {
               _sortPriority = _sortPriority + (param1.item as ScrollItemDescription).color.id * 10000;
               _sortPriority = _sortPriority + (param1.item as ScrollItemDescription).gear.heroLevel;
            }
         }
         if(param4 == param4)
         {
            _excludePriority = param4;
         }
         else
         {
            _excludePriority = _sortPriority;
         }
      }
      
      public function get item() : InventoryItem
      {
         return _item;
      }
      
      public function get dropType() : String
      {
         return _dropType;
      }
      
      public function set externalStyleFactory(param1:Function) : void
      {
         if(param1.length != 0)
         {
            throw new ArgumentError("Метод должен не иметь аргументов и возвращать объект типа GuiElementExternalStyle");
         }
         _externalStyleFactory = param1;
      }
      
      public function createExternalStyle() : GuiElementExternalStyle
      {
         return !!_externalStyleFactory?_externalStyleFactory():null;
      }
      
      public function get sortPriority() : Number
      {
         return _sortPriority;
      }
      
      public function get excludePriority() : Number
      {
         return _excludePriority;
      }
   }
}
