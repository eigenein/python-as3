package game.battle.controller.hero
{
   import battle.BattleLog;
   import battle.Hero;
   import battle.data.BattleHeroDescription;
   import battle.log.BattleLogEncoder;
   import battle.log.BattleLogEvent;
   import battle.log.BattleLogEventHero;
   import battle.log.BattleLogEventHero2;
   import battle.log.BattleLogNameResolver;
   import battle.log.BattleLogReader;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import flash.utils.Dictionary;
   import org.osflash.signals.Signal;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class BattleInspectorLog
   {
      
      public static var instance:BattleInspectorLog;
      
      public static const DEFAULT_COLOR:String = ColorUtils.hexToRGBFormat(16568453);
       
      
      private var log:Vector.<BattleLogEvent>;
      
      private var heroesMap:Dictionary;
      
      public const namer:GameBattleLogNameResolver = new GameBattleLogNameResolver(heroesMap);
      
      public const namerColored:ColoredBattleLogNameResolver = new ColoredBattleLogNameResolver(heroesMap);
      
      public const signal_log:Signal = new Signal(Vector.<BattleLogEvent>);
      
      public const showLog:BooleanPropertyWriteable = new BooleanPropertyWriteable(false);
      
      public function BattleInspectorLog()
      {
         log = new Vector.<BattleLogEvent>();
         heroesMap = new Dictionary();
         super();
         instance = this;
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc2_:String = BattleLog.getLog();
         var _loc3_:Vector.<BattleLogEvent> = BattleLogEncoder.read(new BattleLogReader(_loc2_));
         if(_loc3_.length > 0)
         {
            log = log.concat(_loc3_);
            print(_loc3_);
            signal_log.dispatch(log);
         }
      }
      
      public function registerHero(param1:Hero) : void
      {
         var _loc2_:int = param1.team.direction > 0?param1.desc.id:-param1.desc.id;
         heroesMap[_loc2_] = param1.desc;
      }
      
      public function getFiltered(param1:Vector.<BattleHeroDescription>) : Vector.<BattleLogEvent>
      {
         var _loc5_:int = 0;
         var _loc7_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:Vector.<BattleLogEvent> = new Vector.<BattleLogEvent>();
         var _loc6_:int = log.length;
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc7_ = _loc2_[_loc5_];
            _loc3_ = _loc7_[_loc5_] as BattleLogEventHero;
            _loc4_ = _loc7_[_loc5_] as BattleLogEventHero2;
            if(_loc3_ != null && isHeroLogEvent(_loc3_.heroId,param1))
            {
               _loc2_.push(_loc7_);
            }
            else if(_loc4_ != null && isHeroLogEvent(_loc4_.hero2Id,param1))
            {
               _loc2_.push(_loc7_);
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      protected function isHeroLogEvent(param1:int, param2:Vector.<BattleHeroDescription>) : Boolean
      {
         var _loc3_:BattleHeroDescription = heroesMap[param1];
         return param2.indexOf(_loc3_) != -1;
      }
      
      protected function print(param1:Vector.<BattleLogEvent>) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc7_:int = param1.length;
         var _loc3_:String = "";
         var _loc2_:BattleLogNameResolver = new BattleLogNameResolver();
         var _loc6_:Number = NaN;
         _loc5_ = 0;
         while(_loc5_ < _loc7_)
         {
            _loc4_ = param1[_loc5_];
            if(_loc6_ != _loc4_.time)
            {
               _loc6_ = _loc4_.time;
               _loc3_ = _loc3_ + (_loc6_ + ":\n");
            }
            _loc3_ = _loc3_ + ("   " + _loc4_.toStringShort() + "\n");
            _loc5_++;
         }
      }
   }
}
