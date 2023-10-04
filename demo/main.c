#include "demo.h"

static struct cpu cpu0, cpu1, cpu2, cpu3;

struct cpu *__cpus[] = { &cpu0, &cpu1, &cpu2, &cpu3 };

static void cmd_run(char **tokens)
{
	unsigned mask;
	if (parse_cpu_mask(tokens, &mask) < 0)
		return;

	run_cpus(mask);
}

static void cmd_halt(char **tokens)
{
	unsigned mask;
	if (parse_cpu_mask(tokens, &mask) < 0)
		return;

	halt_cpus(mask);
}

void bsp_main(void)
{
	run_cpu(1);

	while (!cpus_ready());
	print("booted %u cpus", NUM_CPUS);

	while (1) {
		char input[64];
		read_line(input, sizeof input);

		char *tokens = input;

		char *cmd = strtok_input(&tokens);
		if (!cmd)
			continue;

		if (!strcmp(cmd, "run"))
			cmd_run(&tokens);
		else if (!strcmp(cmd, "halt"))
			cmd_halt(&tokens);
		else
			print("unknown command '%s'", cmd);
	}
}

void ap_main(void)
{
	if (this_cpu->num < NUM_CPUS - 1)
		run_cpu(this_cpu->num + 1);

	halt_cpu(this_cpu->num);

	while (1) {
	}
}

void reset(void)
{
	if (this_cpu->num == 0) {
		console_init();

		for (struct cpu **cpu = __cpus; cpu < __cpus + NUM_CPUS; ++cpu) {
		}
	}

	print("core taken out of reset");

	if (this_cpu->num == 0)
		bsp_main();
	else
		ap_main();
}
