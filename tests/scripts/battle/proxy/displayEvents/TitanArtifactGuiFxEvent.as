package battle.proxy.displayEvents
{
   import battle.Team;
   import flash.Boot;
   
   public class TitanArtifactGuiFxEvent extends BattleDisplayEvent
   {
      
      public static var TYPE:String = "TitanArtifactGuiFxEvent";
       
      
      public var team:Team;
      
      public var progress:Number;
      
      public var element:String;
      
      public function TitanArtifactGuiFxEvent(param1:String = undefined, param2:Number = 0.0, param3:Team = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(TitanArtifactGuiFxEvent.TYPE);
         element = param1;
         progress = param2;
         team = param3;
      }
   }
}
