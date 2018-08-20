package
{
   import battle.BattleEngine;
   import flash.Boot;
   import flash.Lib;
   import flash.display.MovieClip;
   
   public dynamic class haxe extends Boot
   {
       
      
      public function haxe()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super();
      }
      
      public static function initSwc(param1:MovieClip) : void
      {
         Lib.current = param1;
         new haxe().init();
      }
      
      override public function init() : void
      {
         BattleEngine.main();
      }
   }
}
