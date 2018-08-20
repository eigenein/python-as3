package game.screen.navigator
{
   import flash.utils.Dictionary;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroObtainType;
   import game.data.storage.mechanic.MechanicDescription;
   import game.data.storage.resource.InventoryItemObtainType;
   import game.data.storage.shop.ShopDescription;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.model.user.Player;
   
   public class InventoryObtainTypeNavigator extends NavigatorBase
   {
       
      
      protected var methodList:Dictionary;
      
      public function InventoryObtainTypeNavigator(param1:GameNavigator, param2:Player)
      {
         var _loc5_:int = 0;
         methodList = new Dictionary();
         super(param1,param2);
         methodList["shop"] = navigateToShop;
         methodList["chest"] = navigateToChest;
         methodList["tower"] = navigateToTower;
         methodList["mechanic"] = navigateToMechanic;
         methodList["event"] = navigateToEvents;
         var _loc3_:Vector.<HeroObtainType> = HeroObtainType.getList();
         var _loc4_:int = _loc3_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_[_loc5_].canNavigateTo = canNavigateToType(_loc3_[_loc5_]);
            _loc5_++;
         }
         var _loc6_:Vector.<InventoryItemObtainType> = InventoryItemObtainType.getList();
         _loc5_ = 0;
         while(_loc5_ < _loc6_.length)
         {
            _loc6_[_loc5_].canNavigateTo = canNavigateToType(_loc6_[_loc5_]);
            _loc5_++;
         }
      }
      
      private function canNavigateToType(param1:InventoryItemObtainType) : Boolean
      {
         return methodList[param1.typeBase] != null;
      }
      
      public function navigate(param1:InventoryItemObtainType, param2:PopupStashEventParams) : void
      {
         if(methodList[param1.typeBase] != null)
         {
            methodList[param1.typeBase](param1,param2);
         }
      }
      
      private function navigateToTower(param1:InventoryItemObtainType, param2:PopupStashEventParams) : void
      {
         var _loc3_:ShopDescription = DataStorage.shop.getByIdent(param1.typeSubject);
         if(_loc3_)
         {
            navigator.navigateToShop(_loc3_,param2);
         }
      }
      
      private function navigateToEvents(param1:InventoryItemObtainType, param2:PopupStashEventParams) : void
      {
         var _loc3_:* = null;
         if(param1 is HeroObtainType)
         {
            _loc3_ = param1 as HeroObtainType;
            if(_loc3_.typeSubjectId)
            {
               navigator.navigateToEvents(param2,int(_loc3_.typeSubjectId));
               return;
            }
         }
         navigator.navigateToEvents(param2);
      }
      
      private function navigateToMechanic(param1:InventoryItemObtainType, param2:PopupStashEventParams) : void
      {
         var _loc3_:MechanicDescription = DataStorage.mechanic.getByType(param1.typeSubject);
         if(_loc3_)
         {
            navigator.navigateToMechanic(_loc3_,param2);
         }
      }
      
      private function navigateToShop(param1:InventoryItemObtainType, param2:PopupStashEventParams) : void
      {
         var _loc3_:ShopDescription = DataStorage.shop.getByIdent(param1.typeSubject);
         if(_loc3_)
         {
            navigator.navigateToShop(_loc3_,param2);
         }
      }
      
      private function navigateToChest(param1:InventoryItemObtainType, param2:PopupStashEventParams) : void
      {
         var _loc3_:MechanicDescription = DataStorage.mechanic.getByType(param1.typeBase);
         if(_loc3_)
         {
            navigator.navigateToMechanic(_loc3_,param2);
         }
      }
   }
}
