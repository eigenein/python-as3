package game.model.user.specialoffer
{
   import engine.core.utils.AbstractMethodError;
   import game.model.user.Player;
   import game.view.gui.components.GuiSubscriber;
   import org.osflash.signals.Signal;
   
   public class PlayerSpecialOfferEntry
   {
       
      
      private var _id:int;
      
      private var _type:String;
      
      protected var player:Player;
      
      protected var offerData:Object;
      
      protected var clientData:Object;
      
      protected var guiSubscriber:GuiSubscriber;
      
      protected var _sideBarIcon:SpecialOfferIconDescription;
      
      public const signal_removed:Signal = new Signal();
      
      public function PlayerSpecialOfferEntry(param1:Player, param2:*)
      {
         super();
         this.player = param1;
         _id = param2.id;
         _type = param2.offerType;
         update(param2);
      }
      
      public function dispose() : void
      {
         signal_removed.dispatch();
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get sideBarIcon() : SpecialOfferIconDescription
      {
         return _sideBarIcon;
      }
      
      public function get signal_updated() : Signal
      {
         throw new AbstractMethodError();
      }
      
      public function start(param1:PlayerSpecialOfferData) : void
      {
         var _loc3_:* = null;
         if(clientData)
         {
            if(clientData.sideBarIcon)
            {
               _sideBarIcon = new SpecialOfferIconDescription(this,clientData.sideBarIcon);
               param1.mainScreenIcons.add(_sideBarIcon);
            }
            var _loc5_:int = 0;
            var _loc4_:* = clientData.view;
            for each(var _loc2_ in clientData.view)
            {
               _loc3_ = new SpecialOfferViewSlotEntry(this,_loc2_);
               param1.addViewSlotEntry(_loc3_);
            }
         }
      }
      
      public function stop(param1:PlayerSpecialOfferData) : void
      {
      }
      
      public function updateExisting(param1:*) : void
      {
         update(param1);
      }
      
      public function toString() : String
      {
         return _id + " " + _type;
      }
      
      protected function update(param1:*) : void
      {
         offerData = param1.offerData;
         clientData = param1.clientData;
      }
   }
}
