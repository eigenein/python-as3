package game.data.storage.gear
{
   import battle.BattleStats;
   import com.progrestar.common.lang.Translate;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.data.storage.resource.InventoryItemDescription;
   
   public class GearItemDescription extends InventoryItemDescription
   {
       
      
      private var _battleStatData:BattleStats;
      
      private var _craftRecipe:GearCraftRecipe;
      
      private var _enchantMultiplier:Number;
      
      private var _heroLevel:int;
      
      public function GearItemDescription(param1:Object)
      {
         _heroLevel = param1.heroLevel;
         _battleStatData = BattleStats.fromRawData(param1.battleStatData);
         _enchantMultiplier = param1.enchantMultiplier;
         super(InventoryItemType.GEAR,param1);
      }
      
      override public function applyLocale() : void
      {
         _name = Translate.translate("LIB_GEAR_NAME_" + id);
         _descText = "";
      }
      
      public function get craftRecipe() : GearCraftRecipe
      {
         return _craftRecipe;
      }
      
      public function get enchantMultiplier() : Number
      {
         return _enchantMultiplier;
      }
      
      public function get battleStatData() : BattleStats
      {
         return _battleStatData;
      }
      
      public function get heroLevel() : int
      {
         return _heroLevel;
      }
      
      function parseCraftRecipe(param1:Object) : void
      {
         if(param1.craftRecipe)
         {
            _craftRecipe = new GearCraftRecipe(param1.craftRecipe);
         }
      }
      
      function unfoldCraftRecipe() : void
      {
         if(_craftRecipe)
         {
            _craftRecipe.unfold(this);
         }
      }
   }
}
