package game.model.user.specialoffer
{
   import game.model.user.Player;
   import game.model.user.refillable.PlayerRefillableEntry;
   import game.view.popup.threeboxes.ThreeBoxesFullScreenPopUpMediator;
   
   public class PlayerSpecialOfferThreeBoxes extends PlayerSpecialOfferWithSideBarIcon
   {
      
      public static const OFFER_TYPE:String = "threeBoxes";
       
      
      public var localeIdent:String;
      
      public var boxes:Vector.<PlayerSpecialOfferLootBox>;
      
      public function PlayerSpecialOfferThreeBoxes(param1:Player, param2:*)
      {
         var _loc5_:* = null;
         var _loc4_:* = null;
         super(param1,param2);
         localeIdent = param2.localeIdent;
         boxes = new Vector.<PlayerSpecialOfferLootBox>();
         var _loc3_:Object = param2.offerData;
         if(_loc3_)
         {
            _loc5_ = _loc3_.lootBoxes;
            if(_loc5_)
            {
               var _loc8_:int = 0;
               var _loc7_:* = _loc5_;
               for(var _loc6_ in _loc5_)
               {
                  _loc4_ = new PlayerSpecialOfferLootBox(_loc6_);
                  _loc4_.deserialize(_loc5_[_loc4_.id]);
                  boxes.push(_loc4_);
               }
            }
         }
         boxes.sort(boxesSort);
      }
      
      override public function get redMarkerVisible() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:Boolean = false;
         _loc3_ = 0;
         while(_loc3_ < boxes.length)
         {
            _loc2_ = player.refillable.getById(boxes[_loc3_].refillable);
            _loc1_ = _loc1_ || _loc2_.canRefill && _loc2_.value > 0;
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function action_popupOpen() : ThreeBoxesFullScreenPopUpMediator
      {
         return new ThreeBoxesFullScreenPopUpMediator(player,this);
      }
      
      private function boxesSort(param1:PlayerSpecialOfferLootBox, param2:PlayerSpecialOfferLootBox) : int
      {
         if(param1.order > param2.order)
         {
            return 1;
         }
         if(param1.order < param2.order)
         {
            return -1;
         }
         return 0;
      }
   }
}
