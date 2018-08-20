package game.model.user.hero.watch
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.artifact.ArtifactDescription;
   import game.data.storage.gear.GearItemDescription;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.resource.PseudoResourceDescription;
   import game.data.storage.resource.ScrollItemDescription;
   import game.data.storage.skin.SkinDescription;
   import game.data.storage.titan.TitanDescription;
   import game.mediator.gui.popup.hero.HeroEntryValueObject;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.hero.PlayerTitanEntry;
   import game.model.user.inventory.InventoryFragmentItem;
   import game.model.user.inventory.InventoryItem;
   
   public class InventoryItemInfoTooltipDataFactory
   {
      
      private static var _instance:InventoryItemInfoTooltipDataFactory;
       
      
      private var heroInventoryWatch:PlayerHeroWatchInventory;
      
      private var source:Player;
      
      public function InventoryItemInfoTooltipDataFactory()
      {
         super();
      }
      
      public static function getHeroFragmentDesc(param1:UnitDescription) : String
      {
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc7_:* = null;
         if(!param1)
         {
            return "";
         }
         if(param1 is HeroDescription)
         {
            _loc6_ = _instance.source.heroes.getById(param1.id);
         }
         if(param1 is TitanDescription)
         {
            _loc4_ = _instance.source.titans.getById(param1.id);
         }
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:InventoryFragmentItem = _instance.source.inventory.getFragmentCollection().getItem(param1) as InventoryFragmentItem;
         if(_loc5_)
         {
            _loc3_ = _loc5_.amount;
         }
         if(_loc6_ || _loc4_)
         {
            if(_loc6_ && _loc6_.star.next || _loc4_ && _loc4_.star.next)
            {
               _loc2_ = !!_loc6_?_loc6_.star.next.star.evolveFragmentCost:int(_loc4_.star.next.star.evolveFragmentCost);
               if(_loc2_ > _loc3_)
               {
                  _loc7_ = !!_loc6_?"LIB_FRAGMENT_HERO_DESC_UPGRADE":"LIB_FRAGMENT_TITAN_DESC_UPGRADE";
                  return Translate.translateArgs(_loc7_,_loc2_ - _loc3_,param1.name);
               }
               _loc7_ = !!_loc6_?"LIB_FRAGMENT_HERO_DESC_UPGRADE_NOW":"LIB_FRAGMENT_TITAN_DESC_UPGRADE_NOW";
               return Translate.translate(_loc7_);
            }
            if(_loc6_)
            {
               return Translate.translate("LIB_FRAGMENT_HERO_DESC_SOULSHOP");
            }
            if(_loc4_)
            {
               return Translate.translateArgs("LIB_FRAGMENT_TITAN_DESC_SOULSHOP");
            }
            return "";
         }
         _loc2_ = param1.fragmentCount;
         if(_loc2_ > _loc3_)
         {
            _loc7_ = param1 is HeroDescription?"LIB_FRAGMENT_HERO_DESC_MORE":"LIB_FRAGMENT_TITAN_DESC_MORE";
            return Translate.translateArgs(_loc7_,_loc2_ - _loc3_,param1.name);
         }
         _loc7_ = param1 is HeroDescription?"LIB_FRAGMENT_HERO_DESC_SUMMON_NOW":"LIB_FRAGMENT_TITAN_DESC_SUMMON_NOW";
         return Translate.translate(_loc7_);
      }
      
      public static function getHeroList(param1:InventoryItem) : Vector.<HeroEntryValueObject>
      {
         var _loc2_:ArtifactDescription = param1.item as ArtifactDescription;
         if(_loc2_)
         {
            return _instance.heroInventoryWatch.getHeroListForArtifact(_loc2_);
         }
         var _loc3_:ScrollItemDescription = param1.item as ScrollItemDescription;
         if(_loc3_ && _loc3_.gear)
         {
            return _instance.heroInventoryWatch.getHeroList(_loc3_.gear);
         }
         var _loc4_:GearItemDescription = param1.item as GearItemDescription;
         if(_loc4_)
         {
            return _instance.heroInventoryWatch.getHeroList(_loc4_);
         }
         return null;
      }
      
      public static function getInStockText(param1:InventoryItem) : String
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         if(param1.item is PseudoResourceDescription)
         {
            return null;
         }
         if(param1 is InventoryFragmentItem)
         {
            if(param1.item is SkinDescription)
            {
               _loc3_ = _instance.source.heroes.getById((param1.item as SkinDescription).heroId);
               if(_loc3_)
               {
                  return null;
               }
               if(_loc2_ > 0)
               {
                  return Translate.translateArgs("UI_DIALOG_HERO_INVENTORY_SLOT_AMOUNT") + " " + _instance.source.inventory.getFragmentCount(param1.item);
               }
               return null;
            }
            _loc2_ = _instance.source.inventory.getFragmentCount(param1.item);
            if(_loc2_ > 0)
            {
               return Translate.translateArgs("UI_DIALOG_HERO_INVENTORY_SLOT_AMOUNT") + " " + _loc2_;
            }
            return null;
         }
         if(param1.item is UnitDescription)
         {
            return null;
         }
         return Translate.translateArgs("UI_DIALOG_HERO_INVENTORY_SLOT_AMOUNT") + " " + _instance.source.inventory.getItemCount(param1.item);
      }
      
      public function init(param1:Player) : void
      {
         this.source = param1;
         this.heroInventoryWatch = param1.heroes.watcher.inventory;
         _instance = this;
      }
   }
}
