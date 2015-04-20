process "narucivanje_jela" do

  description "proces za narucivanje jela"
  start "narucivanje_jela"

  task_action "narucivanje_jela" do

    description "klijent bira jelo"
    input_task "odabir_jela", roles: ["klijent"]
    input_task "izbor_lokacije",roles: ["klijent"]
    next_action "priprema_jela"

  end

  task_action "priprema_jela" do

    description "priprema narucenog jela"
    task "priprema_jela", roles: ["kuhinja"]
    next_action "isporuka_jela"

  end

  task_action "isporuka_jela" do

    task "isporuka_jela", roles: ["dostavljac"]
    next_action "provera_jela"

  end

  input_action "provera_jela" do
    
    question "Da li je sve u redu sa jelom?"
    roles ["klijent", "sef_kuhinje"] 
    next_actions(
      ok: "process:success",
      nije_ok: "priprema_jela"
    )

  end

end