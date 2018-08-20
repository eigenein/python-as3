package game.screen.navigator
{
   import flash.utils.Dictionary;
   import game.data.storage.DataStorage;
   import game.data.storage.mechanic.MechanicDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.data.storage.resource.ObtainNavigatorType;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.model.user.Player;
   
   public class CoinObtainTypeNavigator extends NavigatorBase
   {
       
      
      private var _methodList:Dictionary;
      
      public function CoinObtainTypeNavigator(param1:GameNavigator, param2:Player)
      {
         super(param1,param2);
         _methodList = new Dictionary();
         _methodList["titanList"] = titanList;
         _methodList["toQuizEvent"] = toQuizEvent;
      }
      
      public function navigate(param1:ObtainNavigatorType, param2:PopupStashEventParams) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         if(param1.mechanicIdent)
         {
            _loc4_ = DataStorage.mechanic.getByType(param1.mechanicIdent);
            if(param1.mechanicIdentParams)
            {
               if(_loc4_ == MechanicStorage.BOSS)
               {
                  navigator.mechanicHelper.bossById(param1.mechanicIdentParams[0],param2);
               }
            }
            else if(_loc4_)
            {
               navigator.mechanicHelper.navigate(_loc4_,param2);
            }
         }
         if(param1.methodIdent)
         {
            _loc3_ = this[param1.methodIdent];
            _loc3_(param2);
         }
      }
      
      public function canNavigate(param1:ObtainNavigatorType) : Boolean
      {
         var _loc2_:* = null;
         if(param1.mechanicIdent)
         {
            _loc2_ = DataStorage.mechanic.getByType(param1.mechanicIdent);
            if(_loc2_)
            {
               return true;
            }
         }
         if(param1.methodIdent)
         {
            return true;
         }
         return false;
      }
      
      private function titanList(param1:PopupStashEventParams) : void
      {
         if(!navigator.mechanicHelper.checkIfInClanAndSearchForClanIfNot(param1))
         {
            return;
         }
         PopupList.instance.dialog_titan_list(param1);
      }
      
      private function toQuizEvent(param1:PopupStashEventParams) : void
      {
         navigator.navigateToEvents(param1,38);
      }
   }
}
