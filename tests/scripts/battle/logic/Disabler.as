package battle.logic
{
   import battle.signals.SignalNotifier;
   import battle.skills.Effect;
   import battle.skills.SkillCast;
   import flash.Boot;
   import flash.utils.Dictionary;
   
   public class Disabler
   {
       
      
      public var reasonsCount:int;
      
      public var reasons:Dictionary;
      
      public var onEnable:SignalNotifier;
      
      public var onDisable:SignalNotifier;
      
      public var name:String;
      
      public var enabled:Boolean;
      
      public function Disabler(param1:String = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         onDisable = new SignalNotifier(null,"Disabler.onDisable");
         onEnable = new SignalNotifier(null,"Disabler.onEnable");
         name = param1;
         reasons = new Dictionary();
         reasonsCount = 0;
         enabled = true;
      }
      
      public function unblock(param1:*) : void
      {
         if(!reasons[param1])
         {
            return;
         }
         delete reasons[param1];
         var _loc2_:* = reasonsCount - 1;
         reasonsCount = _loc2_;
         if(_loc2_ == 0)
         {
            if(true != enabled)
            {
               enabled = true;
               onEnable.fire();
            }
         }
      }
      
      public function toString() : String
      {
         var _loc1_:* = null as String;
         var _loc2_:* = null as Dictionary;
         var _loc3_:int = 0;
         var _loc4_:* = null as String;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc7_:* = null as Dictionary;
         var _loc8_:Boolean = false;
         if(reasonsCount > 0)
         {
            _loc1_ = "";
            _loc2_ = reasons;
            _loc3_ = 0;
            while(true)
            {
               _loc7_ = _loc2_;
               _loc5_ = _loc3_;
               _loc8_ = §§hasnext(_loc2_,_loc5_);
               _loc2_ = _loc7_;
               _loc3_ = _loc5_;
               if(!_loc8_)
               {
                  break;
               }
               _loc5_ = _loc3_;
               _loc6_ = §§nextname(_loc5_,_loc2_);
               _loc3_ = _loc5_;
               _loc4_ = _loc6_;
               _loc1_ = _loc1_ + (_loc4_ + " ");
            }
            return "`" + name + "` blocked by " + _loc1_;
         }
         return "`" + name + "` free";
      }
      
      public function setEnabled(param1:Boolean) : void
      {
         if(param1 != enabled)
         {
            enabled = param1;
            if(param1)
            {
               onEnable.fire();
            }
            else
            {
               onDisable.fire();
            }
         }
      }
      
      public function isEnabled() : Boolean
      {
         return enabled;
      }
      
      public function dispose() : void
      {
         onEnable.removeAll();
         onDisable.removeAll();
         enabled = false;
         reasonsCount = 0;
         reasons = null;
      }
      
      public function blockBySkillCast(param1:SkillCast) : void
      {
         if(reasons[param1])
         {
            return;
         }
         param1.addOnStop(unblock);
         reasons[param1] = true;
         if(reasonsCount == 0)
         {
            if(false != enabled)
            {
               enabled = false;
               onDisable.fire();
            }
         }
         reasonsCount = reasonsCount + 1;
      }
      
      public function blockByEffect(param1:Effect) : void
      {
         if(reasons[param1])
         {
            return;
         }
         param1.onRemove.add(unblock);
         reasons[param1] = true;
         if(reasonsCount == 0)
         {
            if(false != enabled)
            {
               enabled = false;
               onDisable.fire();
            }
         }
         reasonsCount = reasonsCount + 1;
      }
      
      public function block(param1:*) : void
      {
         if(reasons[param1])
         {
            return;
         }
         reasons[param1] = true;
         if(reasonsCount == 0)
         {
            if(false != enabled)
            {
               enabled = false;
               onDisable.fire();
            }
         }
         reasonsCount = reasonsCount + 1;
      }
   }
}
