package game.model.user.inventory
{
   import flash.utils.Dictionary;
   import game.data.storage.enum.lib.InventoryItemType;
   
   public class FragmentInventory extends Inventory
   {
       
      
      public function FragmentInventory()
      {
         super();
      }
      
      override protected function get TYPE_LIST() : Vector.<InventoryItemType>
      {
         return InventoryItemType.FRAGMENT_TYPE_LIST;
      }
      
      override public function getCollectionByType(param1:InventoryItemType) : InventoryCollection
      {
         if(collections == null)
         {
            collections = new Dictionary();
         }
         if(collections[param1] == null)
         {
            if(TYPE_LIST.indexOf(param1) == -1)
            {
               trace("Invalid InventoryItemType " + param1.type + " in FragmentInventory.getCollectionByType");
               collections[param1] = new InventoryCollection();
               return collections[param1];
            }
            collections[param1] = new InventoryFragmentCollection();
         }
         return collections[param1];
      }
      
      override public function getInventoryItemType(param1:String) : InventoryItemType
      {
         if(param1 == "fragmentGear")
         {
            param1 = InventoryItemType.GEAR.type;
         }
         else if(param1 == "fragmentScroll")
         {
            param1 = InventoryItemType.SCROLL.type;
         }
         else if(param1 == "fragmentHero")
         {
            param1 = InventoryItemType.HERO.type;
         }
         else if(param1 == "fragmentSkin")
         {
            param1 = InventoryItemType.SKIN.type;
         }
         else if(param1 == "fragmentArtifact")
         {
            param1 = InventoryItemType.ARTIFACT.type;
         }
         else if(param1 == "fragmentTitanArtifact")
         {
            param1 = InventoryItemType.TITAN_ARTIFACT.type;
         }
         return super.getInventoryItemType(param1);
      }
      
      override public function clone() : Inventory
      {
         var _loc1_:FragmentInventory = new FragmentInventory();
         var _loc4_:int = 0;
         var _loc3_:* = TYPE_LIST;
         for each(var _loc2_ in TYPE_LIST)
         {
            _loc1_.getCollectionByType(_loc2_).addCollection(getCollectionByType(_loc2_));
         }
         return _loc1_;
      }
      
      override public function serialize() : Object
      {
         var _loc1_:Object = super.serialize();
         _loc1_["fragmentGear"] = _loc1_[InventoryItemType.GEAR.type];
         _loc1_["fragmentScroll"] = _loc1_[InventoryItemType.SCROLL.type];
         _loc1_["fragmentHero"] = _loc1_[InventoryItemType.HERO.type];
         _loc1_["fragmentTitan"] = _loc1_[InventoryItemType.TITAN.type];
         _loc1_["fragmentArtifact"] = _loc1_[InventoryItemType.ARTIFACT.type];
         _loc1_["fragmentTitanArtifact"] = _loc1_[InventoryItemType.TITAN_ARTIFACT.type];
         delete _loc1_[InventoryItemType.GEAR.type];
         delete _loc1_[InventoryItemType.SCROLL.type];
         delete _loc1_[InventoryItemType.HERO.type];
         return _loc1_;
      }
      
      override public function addRawData(param1:Object) : void
      {
         var _loc2_:Object = {};
         _loc2_[InventoryItemType.GEAR.type] = param1["fragmentGear"];
         _loc2_[InventoryItemType.SCROLL.type] = param1["fragmentScroll"];
         _loc2_[InventoryItemType.HERO.type] = param1["fragmentHero"];
         _loc2_[InventoryItemType.TITAN.type] = param1["fragmentTitan"];
         _loc2_[InventoryItemType.SKIN.type] = param1["fragmentSkin"];
         _loc2_[InventoryItemType.ARTIFACT.type] = param1["fragmentArtifact"];
         _loc2_[InventoryItemType.TITAN_ARTIFACT.type] = param1["fragmentTitanArtifact"];
         _loc2_.lootBoxRewardGroup = param1.lootBoxRewardGroup;
         super.addRawData(_loc2_);
      }
   }
}
