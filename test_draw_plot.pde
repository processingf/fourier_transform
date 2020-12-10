void test_draw_plot() {
  int    i;
  float y[] = new float[100];

  Plot plot_a = new Plot();
  plot_a.backClr = color(70, 70, 80, 20);
  plot_a.borderClr = color(180, 180, 20);
  plot_a.lineClr = color(150, 150, 200);
  plot_a.position = new Dim_int(10, 10);
  plot_a.extent = new Dim_int(300, 240);
  plot_a.borderWidth = 3;
  plot_a.lineWidth = 2;
  plot_a.limTopLeft = new Dim_flt(-(mouseX+20)/10.0, -(mouseY+20)/10.0);
  plot_a.limBottomRight = new Dim_flt((mouseX+20)/10.0, (mouseY+20)/10.0);

  Plot plot_b = new Plot();
  plot_b.backClr = color(70, 70, 80);
  plot_b.borderClr = color(180, 180, 20);
  plot_b.lineClr = color(150, 150, 200);
  plot_b.position = new Dim_int(320, 10);
  plot_b.extent = new Dim_int(300, 240);
  plot_b.borderWidth = 3;
  plot_b.lineWidth = 7;
  plot_b.limTopLeft = new Dim_flt(-(mouseX+20)/10.0, -(mouseY+20)/10.0);
  plot_b.limBottomRight = new Dim_flt((mouseX+20)/10.0, (mouseY+20)/10.0);

  for (i=0; i<100; i++)
    y[i] = sqrt(i);

  Signal sig = new Signal(y);
  plot_a.display(0.0, 0.1, (sig.abs()).realVal);

  for (i=0; i<100; i++)
    y[i] = sqrt(sqrt(i));

  sig = new Signal(y);
  plot_b.display(0.0, 0.1, sig.realVal);
}
