package battle.proxy
{
   import flash.Boot;
   
   public class HeroViewAnchors
   {
       
      
      public var scale:Number;
      
      public var marker:ViewPosition;
      
      public var ground:ViewPosition;
      
      public var chest:ViewPosition;
      
      public function HeroViewAnchors()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         scale = 1;
         marker = new ViewPosition();
         chest = new ViewPosition();
         ground = new ViewPosition();
      }
   }
}
