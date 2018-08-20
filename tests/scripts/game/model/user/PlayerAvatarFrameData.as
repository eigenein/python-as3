package game.model.user
{
   import idv.cjcat.signals.Signal;
   
   public class PlayerAvatarFrameData
   {
      
      public static const DEFAULT_AVATAR_FRAME_ID:int = 0;
       
      
      private var player:Player;
      
      private var _frameId:int;
      
      public const signal_update:Signal = new Signal();
      
      public function PlayerAvatarFrameData(param1:Player)
      {
         super();
         this.player = param1;
      }
      
      public function get frameId() : int
      {
         return _frameId;
      }
      
      public function initFrameId(param1:int) : void
      {
         _frameId = param1;
         player.clan.signal_clanUpdate.add(handler_clanUpdate);
      }
      
      protected function setupFrame(param1:int) : void
      {
         if(param1 == _frameId)
         {
            return;
         }
         _frameId = param1;
         signal_update.dispatch();
      }
      
      private function handler_clanUpdate() : void
      {
         if(player.clan.clan)
         {
            setupFrame(player.clan.clan.frameId);
         }
         else
         {
            setupFrame(0);
         }
      }
   }
}
