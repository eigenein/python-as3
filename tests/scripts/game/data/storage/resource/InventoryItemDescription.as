package game.data.storage.resource
{
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.DescriptionBase;
   import game.data.storage.enum.lib.InventoryItemColor;
   import game.data.storage.enum.lib.InventoryItemType;
   
   public class InventoryItemDescription extends DescriptionBase
   {
       
      
      public var type:InventoryItemType;
      
      public var hidden:Boolean;
      
      public var buyCost:CostData;
      
      public var fragmentBuyCost:CostData;
      
      public var fragmentMergeCost:CostData;
      
      public var sellCost:RewardData;
      
      public var fragmentSellCost:RewardData;
      
      public var enchantValue:int;
      
      public var fragmentEnchantValue:int;
      
      public var assetTexture:String;
      
      public var assetAtlas:int;
      
      protected var _fragmentCount:int;
      
      protected var _color:InventoryItemColor;
      
      protected var _iconAssetTexture:String;
      
      protected var _obtainType:InventoryItemObtainType;
      
      public function InventoryItemDescription(param1:InventoryItemType, param2:Object = null)
      {
         super();
         this.type = param1;
         if(param2)
         {
            hidden = param2.hidden;
            _color = DataStorage.enum.getById_InventoryItemRarity(param2.color);
            if(!_color)
            {
               _color = DataStorage.enum.getById_InventoryItemRarity(1);
            }
            _id = param2.id;
            assetAtlas = param2.assetAtlas;
            assetTexture = param2.assetTexture;
            buyCost = new CostData(param2.buyCost);
            fragmentBuyCost = new CostData(param2.fragmentBuyCost);
            sellCost = new RewardData(param2.sellCost);
            fragmentSellCost = new RewardData(param2.fragmentSellCost);
            if(param2.fragmentMergeCost)
            {
               _fragmentCount = param2.fragmentMergeCost.fragmentCount;
               fragmentMergeCost = new CostData(param2.fragmentMergeCost);
               fragmentMergeCost.fragmentCollection.addItem(this,param2.fragmentMergeCost.fragmentCount);
            }
            enchantValue = param2.enchantValue;
            fragmentEnchantValue = param2.fragmentEnchantValue;
            if(param2.obtainType)
            {
               _obtainType = createObtainType(param2.obtainType);
            }
            _iconAssetTexture = param2.iconAssetTexture;
         }
      }
      
      public function get fragmentCount() : int
      {
         return _fragmentCount;
      }
      
      public function get color() : InventoryItemColor
      {
         return _color;
      }
      
      public function get iconAssetTexture() : String
      {
         return _iconAssetTexture;
      }
      
      public function toString() : String
      {
         return type.type + "." + id;
      }
      
      public function createObtainType(param1:String) : InventoryItemObtainType
      {
         return InventoryItemObtainType.getObject(param1);
      }
      
      public function get obtainType() : InventoryItemObtainType
      {
         return _obtainType;
      }
   }
}
