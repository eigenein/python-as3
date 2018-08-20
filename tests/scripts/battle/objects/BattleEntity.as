package battle.objects
{
   import battle.logic.IRemovable;
   import battle.signals.SignalNotifier;
   import battle.timeline.Scheduler;
   import battle.timeline.Timeline;
   import flash.Boot;
   
   public class BattleEntity extends Scheduler implements IRemovable
   {
       
      
      public var onRemove:SignalNotifier;
      
      public function BattleEntity(param1:Timeline = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         onRemove = new SignalNotifier(this,"BattleEntity.onRemove");
         super(param1);
      }
      
      override public function toString() : String
      {
         return "abstract battleEntity `" + "`";
      }
   }
}
