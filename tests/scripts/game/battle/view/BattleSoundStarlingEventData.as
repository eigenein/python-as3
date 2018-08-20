package game.battle.view
{
   import com.progrestar.framework.ares.extension.sounds.ClipSoundEvent;
   import starling.display.DisplayObject;
   
   public class BattleSoundStarlingEventData
   {
      
      public static const EVENT_SOUND:String = "SOUND";
      
      private static const pool:Vector.<BattleSoundStarlingEventData> = new Vector.<BattleSoundStarlingEventData>();
       
      
      public var event:ClipSoundEvent;
      
      public var object:DisplayObject;
      
      public function BattleSoundStarlingEventData(param1:ClipSoundEvent, param2:DisplayObject)
      {
         super();
         this.event = param1;
         this.object = param2;
      }
      
      public static function create(param1:ClipSoundEvent, param2:DisplayObject) : BattleSoundStarlingEventData
      {
         if(pool.length == 0)
         {
            return new BattleSoundStarlingEventData(param1,param2);
         }
         var _loc3_:BattleSoundStarlingEventData = pool.pop();
         _loc3_.event = param1;
         _loc3_.object = param2;
         return _loc3_;
      }
      
      public function dispose() : void
      {
         event = null;
         object = null;
         pool.push(this);
      }
   }
}
